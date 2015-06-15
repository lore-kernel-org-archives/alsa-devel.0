From: Oder Chiou <oder_chiou@realtek.com>
Subject: Re: [PATCH] ASoC: rt5645: move RT5650 muxes to
	rt5650_specific_dapm_widgets
Date: Mon, 15 Jun 2015 10:29:56 +0000
Message-ID: <7EB0DE829A537248AF2ED30C97D12694F802B8@RTITMBSV03.realtek.com.tw>
References: <1434336251-21807-1-git-send-email-oder_chiou@realtek.com>
 <20150615100420.GF18309@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F09F260870
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2015 12:29:58 +0200 (CEST)
In-Reply-To: <20150615100420.GF18309@sirena.org.uk>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Michele Curti <michele.curti@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Monday, June 15, 2015 6:04 PM
> To: Oder Chiou
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; Flove; Bard Liao; John Lin;
> Michele Curti
> Subject: Re: [PATCH] ASoC: rt5645: move RT5650 muxes to
> rt5650_specific_dapm_widgets
> 
> On Mon, Jun 15, 2015 at 10:44:11AM +0800, Oder Chiou wrote:
> > Developing a driver for an Asus X205TA laptop I get these dmesg
> > errors:
> 
> > Signed-off-by: Michele Curti <michele.curti@gmail.com>
> > Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
> 
> Did Michele write this patch or did you?  It doesn't matter so much when
> all the signoffs come from within the same company but given that
> Michele has a gmail rather than Realtek address the licensing parts of
> the signoff start to matter.

The patch was written by Michele. She sent the patch to us and
alsa-devel@alsa-project.org, but the mail address was not included you.
So we forwarded the patch, thanks.
