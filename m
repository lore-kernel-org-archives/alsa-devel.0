From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH] MAINTAINERS: Add entry for Realtek CODECs
Date: Thu, 31 Jul 2014 12:32:10 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D760670A@RTITMBSV03.realtek.com.tw>
References: <1406807040-3084-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 0899726551F
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 14:32:14 +0200 (CEST)
In-Reply-To: <1406807040-3084-1-git-send-email-broonie@kernel.org>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Oder Chiou <oder_chiou@realtek.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Thursday, July 31, 2014 7:44 PM
> To: Bard Liao; Oder Chiou
> Cc: alsa-devel@alsa-project.org; linaro-kernel@lists.linaro.org; Mark
> Brown
> Subject: [PATCH] MAINTAINERS: Add entry for Realtek CODECs
> 
> From: Mark Brown <broonie@linaro.org>
> 
> Help ensure that patches get sent to the Realtek developers for review by
> adding an explicit MAINTAINERS entry for them.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
> 
> Bard, Oder - are you OK with this being added?

Yes, we are OK and thanks for doing that.

> 
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fcdcaf0fd486..9f72e72a604d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7533,6 +7533,13 @@ F:	drivers/rtc/
>  F:	include/linux/rtc.h
>  F:	include/uapi/linux/rtc.h
> 
> +REALTEK AUDIO CODECS
> +M:	Bard Liao <bardliao@realtek.com>
> +M:	Oder Chiou <oder_chiou@realtek.com>
> +S:	Maintained
> +F:	sound/soc/codecs/rt*
> +F:	include/sound/rt*.h
> +
>  REISERFS FILE SYSTEM
>  L:	reiserfs-devel@vger.kernel.org
>  S:	Supported
> --
> 2.0.1
> 
> 
> ------Please consider the environment before printing this e-mail.
