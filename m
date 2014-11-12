From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH 4/4] ASoC:rt5670:change dapm routes of PLL
	connection
Date: Wed, 12 Nov 2014 06:27:37 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D701020FED@RTITMBSV03.realtek.com.tw>
References: <1415773292-2299-1-git-send-email-bardliao@realtek.com>
 <1415773292-2299-4-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B87126525F
 for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2014 07:27:41 +0100 (CET)
In-Reply-To: <1415773292-2299-4-git-send-email-bardliao@realtek.com>
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
To: "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "mengdong.lin@intel.com" <mengdong.lin@intel.com>, "yao.jin@intel.com" <yao.jin@intel.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Bard Liao
> Sent: Wednesday, November 12, 2014 2:22 PM
> To: broonie@kernel.org; lgirdwood@gmail.com
> Cc: alsa-devel@alsa-project.org; lars@metafoo.de; Flove; Oder Chiou;
> mengdong.lin@intel.com; yao.jin@intel.com; Bard Liao
> Subject: [PATCH 4/4] ASoC:rt5670:change dapm routes of PLL connection
> 
> From: Bard Liao <bardliao@realtek.com>
> 
> PLL should be powered up once filter power is on. So, "PLL1"
> should be connected to filters instead of DACs.
> 
> Signed-off-by: Bard Liao <bardliao@realtek.com>

Please ignore the patch. I sent the wrong one.

Thanks.
