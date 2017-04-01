From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl_ssi: Fix channel swap on
	playback start
Date: Sat, 1 Apr 2017 13:03:37 -0300
Message-ID: <CAOMZO5AGQtqRX+414Rc03WiGwPLsn8F1dh=KjtZf8L91a3Yzkw@mail.gmail.com>
References: <1491058131-31366-1-git-send-email-festevam@gmail.com>
 <43dbe05d-8047-cd2a-80ae-d570e9fb17bd@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f49.google.com (mail-oi0-f49.google.com
 [209.85.218.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 7655F26680A
 for <alsa-devel@alsa-project.org>; Sat,  1 Apr 2017 18:03:39 +0200 (CEST)
Received: by mail-oi0-f49.google.com with SMTP id b187so89201885oif.0
 for <alsa-devel@alsa-project.org>; Sat, 01 Apr 2017 09:03:39 -0700 (PDT)
In-Reply-To: <43dbe05d-8047-cd2a-80ae-d570e9fb17bd@invoxia.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Sascha Hauer <kernel@pengutronix.de>, Timur Tabi <timur@tabi.org>, Caleb Crome <caleb@crome.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Max Krummenacher <max.krummenacher@toradex.com>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org

Hi Arnaud,

On Sat, Apr 1, 2017 at 12:13 PM, Arnaud Mouiche
<arnaud.mouiche@invoxia.com> wrote:

> I will take time to look at the possible impact on imx6 using my previous
> test method.

Excellent, your testing will be appreciated, thanks.
