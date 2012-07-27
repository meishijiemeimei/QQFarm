package com._public._method    
{    
    import flash.net.LocalConnection;    
    public class ClearMemory    
    {    
        private static var Instance:ClearMemory = new ClearMemory;    
        public static function getInstance():ClearMemory {    
            return Instance;    
        }    
        public function runClear():void{    
                try {    
                  new LocalConnection().connect('shch8.com');    
                  new LocalConnection().connect('shch8.com');    
                } catch (e:*) {    
                }    
            }    
    }    
}