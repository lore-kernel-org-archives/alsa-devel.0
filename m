From: Dmitry Baikov <dsbaikov@gmail.com>
Subject: Re: RME HDSP rev 37 does not work on 64-bit linux
Date: Sun, 1 Feb 2009 19:46:38 +0300
Message-ID: <70a871c80902010846i1059ab26t63c1d7e530126caf@mail.gmail.com>
References: <70a871c80902010708s2a10ff8bobe79622949da62fe@mail.gmail.com>
	<70a871c80902010713p2b49c7cbj98356d56bdb4ed62@mail.gmail.com>
	<200902011616.49454.faber@faberman.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f19.google.com (mail-fx0-f19.google.com
	[209.85.220.19]) by alsa0.perex.cz (Postfix) with ESMTP id 7554D24373
	for <alsa-devel@alsa-project.org>; Sun,  1 Feb 2009 17:46:39 +0100 (CET)
Received: by fxm12 with SMTP id 12so1032727fxm.8
	for <alsa-devel@alsa-project.org>; Sun, 01 Feb 2009 08:46:38 -0800 (PST)
In-Reply-To: <200902011616.49454.faber@faberman.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Florian Faber <faber@faberman.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Feb 1, 2009 at 6:16 PM, Florian Faber <faber@faberman.de> wrote:
> Dmitry,
>
>> under 32-bit ubuntu 8.10 with the same kernel 2.6.27-11-generic and
>> the same version of alsa-*: 1.0.17-0ubuntu1,
>> everything works fine both with cold boot + hdsploader and winxp ->
>> reboot-> no hdsploader.
>
> It works fine with 64 bit linux, I have pure 64 bit machines and all hdsp(e)
> cards work as they should. Must be something else then.

Which distribution/kernel(s) do you use?

I just revived my 64-bit Gentoo partition, and vanilla 2.6.28.2 says
No Multiface or Digiface found, disabling the card.


Dmitry.
