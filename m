From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2 2/2] ASoC: fsl_sai: Allow setting the
	SAI MCLK direction
Date: Wed, 4 May 2016 19:24:18 -0300
Message-ID: <CAOMZO5AaZ0tC6pD+KL_kWg-usuUBvy55mTmZn02vzpKi6FpZUA@mail.gmail.com>
References: <1462398172-24377-1-git-send-email-festevam@gmail.com>
 <1462398172-24377-2-git-send-email-festevam@gmail.com>
 <20160504215643.GB11381@Asurada-Nvidia>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f173.google.com (mail-io0-f173.google.com
 [209.85.223.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 40D0F2651CB
 for <alsa-devel@alsa-project.org>; Thu,  5 May 2016 00:24:19 +0200 (CEST)
Received: by mail-io0-f173.google.com with SMTP id f89so68745630ioi.0
 for <alsa-devel@alsa-project.org>; Wed, 04 May 2016 15:24:19 -0700 (PDT)
In-Reply-To: <20160504215643.GB11381@Asurada-Nvidia>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Petr Kulhavy <brain@jikos.cz>
List-Id: alsa-devel@alsa-project.org

On Wed, May 4, 2016 at 6:56 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:

> Do we need to add this to binding doc as well? Or will it be better
> to use alias here? I am not sure though.

Yes, using alias is better :-) Will use it in v3, thanks.
