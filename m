From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8962: correct addresses for
	HPF_C_0/1
Date: Thu, 12 Nov 2015 08:11:51 +0000
Message-ID: <20151112081151.GA18889@ck-lbox>
References: <1447178038-11156-1-git-send-email-sachinpandhare@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BB83264F8D
 for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2015 09:27:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1447178038-11156-1-git-send-email-sachinpandhare@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: sachinpandhare@gmail.com
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, axel.lin@ingics.com, zidan.wang@freescale.com, jiada_wang@mentor.com, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 10, 2015 at 11:23:58PM +0530, sachinpandhare@gmail.com wrote:
> From: Sachin Pandhare <sachinpandhare@gmail.com>
> 
> >From datasheet:
> R17408 (4400h) HPF_C_1
> R17409 (4401h) HPF_C_0
> 17048 -> 17408 (0x4400)
> 17049 -> 17409 (0x4401)
> 
> Signed-off-by: Sachin Pandhare <sachinpandhare@gmail.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
