# cocktaildb

## Introduction

Тестовое задание "Cocktail DB".

#### *Примечания*

- Если проект не сбилдится, скорее всего, надо будет удалить Pods и заново поставить (все зависимости имеются в podfile).
- *Warning "Using 'class' keyword for protocol inheritance is deprecated; use 'AnyObject' instead"*: для того, чтобы определять weak reference через протоколы, нужно использовать ключевое слово *class*, с *AnyObject* это сделать нельзя. Поэтому, оставила *class*, хоть и выдает, что оно устаревшее.


## Built with
  - **Language:** *Swift 5*
  - **UI:** *Programmatically*
  - **Network:** *Moya+Codable*
  - **DI:** *Resolver*
  - **Other Frameworks:** *RxSwift, R.swift, SnapKit, MBProgressHUD, SDWebImageView*
