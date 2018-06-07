From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: dapm: update function comments
Date: Thu, 7 Jun 2018 13:48:37 +0100
Message-ID: <20180607124837.GC18740@imbe.wolfsonmicro.main>
References: <20180606160736.169077-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id DCEF12670BE
 for <alsa-devel@alsa-project.org>; Thu,  7 Jun 2018 14:48:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180606160736.169077-1-tzungbi@google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tzung-Bi Shih <tzungbi@google.com>
Cc: alsa-devel@alsa-project.org, cychiang@google.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 07, 2018 at 12:07:36AM +0800, Tzung-Bi Shih wrote:
> snd_soc_dapm_put_volsw() and snd_soc_dapm_put_enum_double() returns
> 0 if the value is unchanged and 1 if changed. Both 0 and 1 indicate
> a success.
> 
> Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
