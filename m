From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH] TXx9: Add ACLC support
Date: Fri, 15 May 2009 15:45:36 +0200 (CEST)
Message-ID: <alpine.LRH.2.00.0905151516300.32617@vixen.sonytel.be>
References: <1242312605-2160-2-git-send-email-anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1242312605-2160-2-git-send-email-anemo@mba.ocn.ne.jp>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: Linux/MIPS Development <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 14 May 2009, Atsushi Nemoto wrote:
> Add platform support for ACLC of TXx9 SoCs.

I gave it a try on my RBTX4927, and after some fight^H^H^H^H^Hplaying w=
ith the
alsa tools, I could play sound using `speaker-test --test wav --channel=
s 2'!

With kind regards,

Geert Uytterhoeven
Software Architect
Techsoft Centre

Technology and Software Centre Europe
The Corporate Village =B7 Da Vincilaan 7-D1 =B7 B-1935 Zaventem =B7 Bel=
gium

Phone:    +32 (0)2 700 8453
=46ax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 =B7 RPR Brussels
=46ortis =B7 BIC GEBABEBB =B7 IBAN BE41293037680010
