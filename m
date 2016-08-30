From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: core: fix shift used for second
 item in snd_soc_get_enum_double
Date: Tue, 30 Aug 2016 09:41:20 +0100
Message-ID: <20160830084120.GW21682@localhost.localdomain>
References: <1472483218-11987-1-git-send-email-jjassal@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id B54712669D5
 for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2016 10:41:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1472483218-11987-1-git-send-email-jjassal@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaswinder Jassal <jjassal@opensource.wolfsonmicro.com>
Cc: tiwai@suse.com, broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 29, 2016 at 04:06:58PM +0100, Jaswinder Jassal wrote:
> Incorrect shift value was being used to extract the second item.
> 
> Signed-off-by: Jaswinder Jassal <jjassal@opensource.wolfsonmicro.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
