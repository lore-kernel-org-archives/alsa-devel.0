From: Andreas Reis <andreas.reis@gmail.com>
Subject: Re: [Report] ALSO: hda - CA0132: Bugs and missing
	features
Date: Fri, 22 Nov 2013 13:28:08 +0100
Message-ID: <528F4DD8.5000703@gmail.com>
References: <CAEUnVG4KukHXSSiJgQSyBt8gJY+=mw1BnKqiK3Ht-RgrXiAY7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f45.google.com (mail-bk0-f45.google.com
 [209.85.214.45])
 by alsa0.perex.cz (Postfix) with ESMTP id F0140261A63
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2013 13:28:09 +0100 (CET)
Received: by mail-bk0-f45.google.com with SMTP id mx13so758630bkb.4
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2013 04:28:09 -0800 (PST)
In-Reply-To: <CAEUnVG4KukHXSSiJgQSyBt8gJY+=mw1BnKqiK3Ht-RgrXiAY7w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

So realistically, either Creative finally provides the required support 
or most CA0132 users can wait until the cows come home. Maybe I'll try 
to contact Gigabyte and Creative's Ian Minett directly.

(Guess that's what I get for buying supposedly better hardware without 
checking for proper Linux support.)

Nonetheless, thanks for the reply, I understand the problem.

On 20.11.2013 19:10, Dylan Reid wrote:
> Sorry I don't have good news for you.  The CA0132 is very dependent on
> the firmware that is loaded into the DSP that resides in the codec.
>
> To get your system to work you'll have to obtain the firmware that was
> designed for your motherboard, then change the Linux driver to be able
> to talk to it, without a spec for how it works.
>
> This is not impossible, but it would be rather time consuming.
>
> -Dylan
