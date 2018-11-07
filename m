From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: Change to use
 DEFINE_SHOW_ATTRIBUTE macro
Date: Wed, 7 Nov 2018 17:08:28 -0200
Message-ID: <CAOMZO5C+TSGY4wJmZbMW7rVSp4RKcXLH90Em3D5LxZTP-W00Xw@mail.gmail.com>
References: <20181105143730.6071-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 96D7E26751A
 for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2018 20:08:39 +0100 (CET)
Received: by mail-ot1-f66.google.com with SMTP id q5so15753812otl.13
 for <alsa-devel@alsa-project.org>; Wed, 07 Nov 2018 11:08:39 -0800 (PST)
In-Reply-To: <20181105143730.6071-1-tiny.windzz@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiny.windzz@gmail.com
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, timur@kernel.org, Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 7, 2018 at 4:57 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
