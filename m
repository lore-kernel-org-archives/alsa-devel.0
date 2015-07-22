From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH RFT] ASoC: sgtl5000: Fix up define for
	SGTL5000_SMALL_POP
Date: Wed, 22 Jul 2015 07:55:51 -0300
Message-ID: <CAOMZO5Acm2eDaOg_Bh1O8S3r6Z=osC0Yxu_0vdk67QVbw8zqkQ@mail.gmail.com>
References: <1437535665.17780.1.camel@ingics.com> <1979834.BYYY6Fhuui@ws-stein>
 <CAFRkauBy06Ua6UZ1oonH9asb8pHXc045V4o-tVEGZEAMbm8MLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f181.google.com (mail-lb0-f181.google.com
 [209.85.217.181])
 by alsa0.perex.cz (Postfix) with ESMTP id B91572606D8
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2015 12:55:54 +0200 (CEST)
Received: by lbbyj8 with SMTP id yj8so134150880lbb.0
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2015 03:55:52 -0700 (PDT)
In-Reply-To: <CAFRkauBy06Ua6UZ1oonH9asb8pHXc045V4o-tVEGZEAMbm8MLw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Filip Brozovic <fbrozovic@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Zeng Zhaoming <zengzm.kernel@gmail.com>, Alexander Stein <alexander.stein@systec-electronic.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 22, 2015 at 6:45 AM, Axel Lin <axel.lin@ingics.com> wrote:

> I just checked the datasheet and confirm the SMALL_POP is BIT(0).

Yes, this is correct:

Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>
