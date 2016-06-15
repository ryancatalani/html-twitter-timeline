# About

Generates a lightweight HTML page of a Twitter user's latest tweets, and uploads it to S3. Updating can be triggered via `ruby update.rb` or by visiting `/update`. Meant to be embedded in an `iframe` where normal [embedded Twitter timelines](https://support.twitter.com/articles/20170071) may not work. Set up to work with Heroku.

Requires:

- Choosing a Twitter user and setting `USERNAME` environment variable.
- Creating a Twitter app and setting `CONSUMER_KEY`, `CONSUMER_SECRET`, `ACCESS_TOKEN`, `ACCESS_TOKEN_SECRET` environment variables.
- Creating an AWS user and setting `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS`.

# License (MIT)

Copyright (c) 2016 Ryan Catalani.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.