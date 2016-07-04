From: Garlic Tseng <garlic.tseng@mediatek.com>
Subject: Re: [PATCH v5 7/9] ASoC: bt-sco: extend rate and add a
 general compatible string
Date: Mon, 4 Jul 2016 09:59:17 +0800
Message-ID: <1467597557.11819.4.camel@mtksdaap41>
References: <1466149440-23889-1-git-send-email-garlic.tseng@mediatek.com>
 <1466149440-23889-8-git-send-email-garlic.tseng@mediatek.com>
 <20160629191500.GU6247@sirena.org.uk>
 <1467291345.11091.16.camel@mtksdaap41>
 <1467341386.21689.6.camel@mtksdaap41> <20160701161105.GY6247@sirena.org.uk>
 <CAGb2v67rgj4efyTZpZ-79NnCRM=KLJCJedte594qgSjMMB5xsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B9D726582F
 for <alsa-devel@alsa-project.org>; Mon,  4 Jul 2016 03:59:22 +0200 (CEST)
In-Reply-To: <CAGb2v67rgj4efyTZpZ-79NnCRM=KLJCJedte594qgSjMMB5xsQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: alsa-devel@alsa-project.org, ir.lian@mediatek.com, srv_heupstream@mediatek.com, tiwai@suse.de, linux-kernel <linux-kernel@vger.kernel.org>, koro.chen@mediatek.com, Mark Brown <broonie@kernel.org>, "moderated list:ARM/Mediatek SoC..." <linux-mediatek@lists.infradead.org>, PC.Liao@mediatek.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 2016-07-02 at 17:05 +0800, Chen-Yu Tsai wrote:

Hi,

> Could we also make this driver directly configurable from Kconfig,
> and not just selected by platforms (currently Samsung) or by building
> all coddecs?
> 
> Thanks
> ChenYu

I'll add configure prompt for SND_SOC_BT_SCO in next patchset.
Thanks for comment.

Garlic
