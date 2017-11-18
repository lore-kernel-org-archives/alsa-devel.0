From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_asrc: Fix typo in a field define
Date: Sat, 18 Nov 2017 21:14:51 -0200
Message-ID: <CAOMZO5DPAiqFAeePNGnT0GrB6GfH5Lk=0b_ce9g8Lj1VjAL4Qg@mail.gmail.com>
References: <1510862118-16104-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
 [209.85.218.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 59E39266EFA
 for <alsa-devel@alsa-project.org>; Sun, 19 Nov 2017 00:14:53 +0100 (CET)
Received: by mail-oi0-f68.google.com with SMTP id f135so4019754oib.0
 for <alsa-devel@alsa-project.org>; Sat, 18 Nov 2017 15:14:52 -0800 (PST)
In-Reply-To: <1510862118-16104-1-git-send-email-nicoleotsuka@gmail.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, laurent.charpentier@nxp.com, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 16, 2017 at 5:55 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> ASRFSTi_IAEi has an 11-bit offset as its _SHIFT macro defines.
>
> So this patch just fixes that.
>
> Reported-by: Laurent Charpentier <laurent.charpentier@nxp.com>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
