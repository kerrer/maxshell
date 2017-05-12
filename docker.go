package main

import (
   "fmt"
   "time"
   "math/rand"
   "strconv"
   "os"
   pflag "github.com/spf13/pflag"
)


type Empty interface{}

type Semaphore struct {
    dur time.Duration
    ch  chan Empty
}

func NewSemaphore(max int, dur time.Duration) (sem *Semaphore) {
    sem = new(Semaphore)
    sem.dur = dur
    sem.ch = make(chan Empty, max)
    return
}

type Timeout struct{}

type Work struct{}

var null Empty
var timeout Timeout
var work Work

var global = time.Now()

func (sem *Semaphore) StartJob(id int, job func()) {
    sem.ch <- null
    go func() {
        ch := make(chan interface{})
        go func() {
            time.Sleep(sem.dur)
            ch <- timeout
        }()
        go func() {
            fmt.Println("Job ", strconv.Itoa(id), " is started", time.Since(global))
            job()
            ch <- work
        }()
        switch (<-ch).(type) {
        case Timeout:
            fmt.Println("Timeout for job ", strconv.Itoa(id), time.Since(global))
        case Work:
            fmt.Println("Job ", strconv.Itoa(id), " is finished", time.Since(global))
        }
        <-sem.ch
    }()
}

func main() {
	var ip = pflag.IntP("flagname", "f", 1234, "help message")
    var flagvar = pflag.BoolP( "boolname", "b", true, "help message")
    var flagval = pflag.StringP("varname", "v","ok", "help message")
	

    pflag.Parse()
    fmt.Println(*ip)
     fmt.Println(*flagvar)
      fmt.Println(*flagval)
    os.Exit(1)
    
    rand.Seed(time.Now().Unix())
    sem := NewSemaphore(3, 3*time.Second)
    for i := 0; i < 10; i++ {
        id := i
        go sem.StartJob(i, func() {
            seconds := 2 + rand.Intn(5)
            fmt.Println("For job ", strconv.Itoa(id), " was allocated ", seconds, " secs")
            time.Sleep(time.Duration(seconds) * time.Second)
        })
    }
    time.Sleep(30 * time.Second)
}
