import hilog from '@ohos.hilog'

const DOMAIN = 0xFF09
const PREFIX = 'Ansen'
const FORMAT = '%{public}s, %{public}s'

class Logger{
  public isDebug=false;

  debug(...args: string[]) {
    if (!this.isDebug){
      return ;
    }
    hilog.debug(DOMAIN, PREFIX, FORMAT, args)
  }

  info(...args: string[]) {
    if (!this.isDebug){
      return ;
    }
    hilog.info(DOMAIN, PREFIX, FORMAT, args)
  }

  warn(...args: string[]) {
    if (!this.isDebug){
      return ;
    }
    hilog.warn(DOMAIN, PREFIX, FORMAT, args)
  }

  error(...args: string[]) {
    if (!this.isDebug){
      return ;
    }
    hilog.error(DOMAIN, PREFIX, FORMAT, args)
  }

  fatal(...args: string[]) {
    if (!this.isDebug){
      return ;
    }
    hilog.fatal(DOMAIN, PREFIX, FORMAT, args)
  }

  isLoggable(level: hilog.LogLevel) {
    if (!this.isDebug){
      return ;
    }
    hilog.isLoggable(DOMAIN, PREFIX, level)
  }
}

export const logger = new Logger()