From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [EXTERNAL] [PATCH 0/2] ASoC: cs35l32: Adjustments
 for cs35l32_i2c_probe()
Date: Mon, 27 Nov 2017 08:47:26 -0600
Message-ID: <d04fe61d-f56d-4faf-a337-aa131b7513a2@EX3.ad.cirrus.com>
References: <caf22f25-6c27-b869-89e8-ef2904a2baf2@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 59160266DCC
 for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2017 15:47:09 +0100 (CET)
In-Reply-To: <caf22f25-6c27-b869-89e8-ef2904a2baf2@users.sourceforge.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 22 Nov 2017, SF Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 22 Nov 2017 20:49:45 +0100
> 
> Two update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (2):
>   Delete two error messages for a failed memory allocation
>   Improve two size determinations
> 
>  sound/soc/codecs/cs35l32.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> -- 
> 2.15.0
> 
> 
For the series, Thanks
Acked-by: Brian Austin <brian.austin@cirrus.com>
