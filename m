From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3 0/6] ASoC: fsl_ssi: Fixing various
 channel slips and bad samples insertions
Date: Fri, 29 Apr 2016 00:44:16 -0300
Message-ID: <CAOMZO5A0FRZ52UGeqLJaVF8BiWhzmpNSgQm4B0U1gc2wGU6KhA@mail.gmail.com>
References: <1453130771-24419-1-git-send-email-arnaud.mouiche@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f182.google.com (mail-io0-f182.google.com
 [209.85.223.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 23DDA26518B
 for <alsa-devel@alsa-project.org>; Fri, 29 Apr 2016 05:44:17 +0200 (CEST)
Received: by mail-io0-f182.google.com with SMTP id f89so96591761ioi.0
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2016 20:44:17 -0700 (PDT)
In-Reply-To: <1453130771-24419-1-git-send-email-arnaud.mouiche@invoxia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Caleb Crome <caleb@crome.org>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Nicolin and Timur,

On Mon, Jan 18, 2016 at 1:26 PM, Arnaud Mouiche
<arnaud.mouiche@invoxia.com> wrote:
>
> This series of patch is an attempt to fix the fsl_ssi driver to use it in TDM mode (DSP A or B) with a large number of channels/slots.

Any feedback about this series?

It addresses important fixes for the fsl_ssi driver.
