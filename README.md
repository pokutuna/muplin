# muplin
muplin(むぷりん)とは、MUりやり Pdf に outLIN をつけるやつの略で、

PDFにoutline(目次、しおり、table of content とか呼ばれる)をつけることができます。

outlineとは章タイトル等をクリックするとそのページに飛べるアレです。


## install
`$ gem install muplin`


## usage
`$ muplin --help`

    Muplin is a MUriyari Pdf outLINer. https://github.com/pokutuna/muplin
    Usage: muplin <source.pdf> <outline(.yaml|.json)> [options]
        -o, --output=FILE                write pdf to FILE. default: ./muplined.pdf
            --overwrite                  overwrite to <source.pdf>

`$ muplin sample.pdf outline.yaml`


## use from ruby
    require 'muplin'
    require 'yaml'
     
    doc = Muplin::Outliner.new('sample.pdf')
    doc.clear_outlines
    doc.define_outline(YAML.load_file('outline.yaml'))
    doc.render_file('muplined.pdf')


## outline

アウトラインを表すHash(e.g. { 'label' => 'page 1', 'page' => 1 })のArrayです。

yamlまたはjsonに対応しています。

### 記述例

sample/outline.yaml

    --- 
    - label : a
      page  : 1
    - label : b
      page  : 2
    - label : c
      page  : 3
    - - label : d
        page  : 4
      - label : e
        page  : 5
    - label : f
      page  : 6
    - label : g
      page  : 7
    - - label : h
        page  : 8
    - - - label : i
          page  : 9


sample/outline.json

    [
        {"label":"a","page":1},
        {"label":"b","page":2},
        {"label":"c","page":3},
        [
            {"label":"d","page":4},
            {"label":"e","page":5}
        ],
        {"label":"f","page":6},
        {"label":"g","page":7},
        [
            {"label":"h","page":8},
            [
                {"label":"i","page":9}
            ]
        ]
    ]


## どこが無理やりなのか

* 画像があるPDFだと割りと壊れた感じのファイルが出力される
* 元ある目次が内部的には消えてない、同じファイルに何度も目次をつけると目次のぶんサイズがでかくなっていくのが分かる
