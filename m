From: undefined@alsa-project.org
Subject: Re: [PATCH] ASoC: imx-ssi: Fix DAI hardware signal
	inversions
Date: Fri, 18 Sep 2015 19:51:16 -0500
Message-ID: <55FCB184.2030702@tabi.org>
References: <1442504814-16965-1-git-send-email-benoit@wsystem.com>
 <20150917175927.GB2544@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id 75EAE26049B
 for <alsa-devel@alsa-project.org>; Sat, 19 Sep 2015 02:51:18 +0200 (CEST)
In-Reply-To: <20150917175927.GB2544@Asurada-CZ80>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>, =?UTF-8?Q?Beno=c3=aet_Th=c3=a9baudeau?= <benoit@wsystem.com>
Cc: alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>
List-Id: alsa-devel@alsa-project.org

Nicolin Chen wrote:
> Looks like the same configurations of fsl_ssi, so it should be fine:

I'm so glad I ignored the IMX driver when I wrote fsl_ssi.c. :-)
