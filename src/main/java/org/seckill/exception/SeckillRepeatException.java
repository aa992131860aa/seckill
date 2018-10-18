package org.seckill.exception;

public class SeckillRepeatException extends SeckillException {

    public SeckillRepeatException(String message) {
        super(message);
    }

    public SeckillRepeatException(String message, Throwable cause) {
        super(message, cause);
    }
}
