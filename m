From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: [PATCH v5] sound/soc/lapis: add machine driver for
	ML7213 Carrier Board
Date: Wed, 7 Mar 2012 10:57:07 +0900
Message-ID: <CANKRQngTNWMGswq3weD1s8O4irVEz+DCr1vzi2gnWaQcoq5SEw@mail.gmail.com>
References: <1329976011-2251-1-git-send-email-tomoya.rohm@gmail.com>
	<1329976011-2251-3-git-send-email-tomoya.rohm@gmail.com>
	<20120302130509.GF3230@opensource.wolfsonmicro.com>
	<CANKRQnhHo1P0cmxyfUAShTinWMv0B81d8v8f7M6Oj3Yx9807zg@mail.gmail.com>
	<20120306115407.GE19635@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f49.google.com (mail-pz0-f49.google.com
	[209.85.210.49])
	by alsa0.perex.cz (Postfix) with ESMTP id F13A1103D08
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 02:57:09 +0100 (CET)
Received: by dakp5 with SMTP id p5so7690751dak.8
	for <alsa-devel@alsa-project.org>; Tue, 06 Mar 2012 17:57:07 -0800 (PST)
In-Reply-To: <20120306115407.GE19635@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, qi.wang@intel.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, yong.y.wang@intel.com, kok.howg.ewe@intel.com, Liam Girdwood <lrg@ti.com>, joel.clark@intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 6, 2012 at 8:54 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
>> > You're also missing a blank line between this and the previous stanza.
>> Sorry, I can't understand your saying.
> Your file should look like other similar files in the kernel.

Aha, I could understand.
Need to add blank line before "config SND_SOC_ML7213_MACHINE" line.

thanks.
-- 
ROHM Co., Ltd.
tomoya
