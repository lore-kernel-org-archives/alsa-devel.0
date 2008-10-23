From: "John Kacur" <jkacur@gmail.com>
Subject: Re: ASOC on OMAP3+twl4030
Date: Thu, 23 Oct 2008 09:01:11 +0200
Message-ID: <520f0cf10810230001l64e2751bqbd4da5b1d9fbeea8@mail.gmail.com>
References: <ef0d8a250810222341i54fe3d97mbc90003f2d07acb0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E18724427
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Oct 2008 09:01:29 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id l35so110155waf.16
	for <alsa-devel@alsa-project.org>; Thu, 23 Oct 2008 00:01:11 -0700 (PDT)
In-Reply-To: <ef0d8a250810222341i54fe3d97mbc90003f2d07acb0@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: naveen krishna ch <naveenkrishna.ch@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 23, 2008 at 8:41 AM, naveen krishna ch
<naveenkrishna.ch@gmail.com> wrote:
> Hello all,
> I am reporting an issue for last 4 days and i am not getting enough response
> fromt he mailing list.
>
> My issue is with the asoc drivers for omap3 and twl4030 combination which
> are available in the latest git kernel.
>
> Audio is working on my custom board when i boot out of MMC but the same
> setup (x-laod, u-boot and uImage and hadware)  the audio is not working when
> i boot out of NAND.
>
> Can any one help me in debugging the issue.
>
> Background:
> I am using 2.6.26 linux kernel i have ported soc stuff from 2.6.27 latest
> git kernel for omap3 mcbsp and twl4030 codec support.. the audio is working
> when i use it on OMAP3EVM even though it is booted out of NAND.
>
> I am getting very less replies against my issue am i posting to wrong people
> or what
> can any one tell me how can i make use of this mailing list to its fullest
> --
> Thank You all,

Hmnn, I have gotten very good responses posting to the list, but a few
words of open source etiquette here might be in order, but the problem
could be exasperated if English isn't your first language. First of
all, no-one HAS to help you if they don't want. After all you are not
paying them, so they are doing so strictly on a voluntary basis, so
you can't demand that people help you, you just have to ask nicely.
Second of all, where is your code? Try posting your code, and then
giving a little more details about how you tried to debug this, or ask
a more specific question, like "how do I go about debugging this" -
and you will probably get some better responses.

Good luck
John
