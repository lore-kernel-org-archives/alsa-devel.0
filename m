From: "Munzir Taha (=?utf-8?q?=D9=85=D9=86=D8=B0=D8=B1?=
	=?utf-8?q?_=D8=B7=D9=87?=)" <munzirtaha@gmail.com>
Subject: Re: OFFTOPIC atkbd.c: Use 'setkeycodes... (Was: Re: My
	Codec: IDT 92HD75B3X5 issues)
Date: Fri, 2 Oct 2009 18:37:02 +0300
Message-ID: <200910021837.03060.munzirtaha@gmail.com>
References: <598e9210910020512j67cfad99i7369bbd34228f3c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 0377924505
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Oct 2009 17:37:08 +0200 (CEST)
Received: by fxm8 with SMTP id 8so1238249fxm.45
	for <alsa-devel@alsa-project.org>; Fri, 02 Oct 2009 08:37:08 -0700 (PDT)
In-Reply-To: <598e9210910020512j67cfad99i7369bbd34228f3c0@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Simos Xenitellis <simos.lists@googlemail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Simons,

As far as I know HAL is deprecated in favor of udev and DeviceKit so may be I 
should file a bug against udev instead.

Thanks for your care to elaborate

On Yaum al-Jumma 12 Shawwal 1430 3:12:21 pm Simos Xenitellis wrote:

> > You are right. What's the best component to report this bug against?
> > kernel?
> 
> Those keys are a 'HAL' thing. Until recently there has been a website
> by the HAL developer
> with detailed instructions. Search for 'HAL Quirk Site' on Google to
> view the site in Google cache.
> The website was not updated for some time
> (http://www.mail-archive.com/pm-utils@lists.freedesktop.org/msg01594.html)
> and being obsolete, it was probably taken down.
> Your changes would need to make it eventually to the hal-info repository,
> http://cgit.freedesktop.org/hal-info/
> Use the Freedesktop Bugzilla, product 'hal' and component 'hal-info'
> when reporting,
> https://bugs.freedesktop.org/enter_bug.cgi?product=hal
> 
> Simos
> 


-- 
Munzir Taha
Telecommunications and Electronics Engineer
Maintainer of Fedora Arabic Translation Project
https://listman.redhat.com/mailman/listinfo/fedora-trans-ar
Maintainer of the OpenBugs project page at
http://foss.org.sa/OpenBugs.html
Master CIW Designer, ICDL, MOUS, Linux+, LPI, SCSA
Riyadh, SA
