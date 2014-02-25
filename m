From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH v4] ASoC: add RT286 CODEC driver
Date: Tue, 25 Feb 2014 08:58:06 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D7380472@RTITMBSV03.realtek.com.tw>
References: <1393311589-14315-1-git-send-email-bardliao@realtek.com>
 <s5htxbnvbwa.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DAF62652C1
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2014 09:58:12 +0100 (CET)
In-Reply-To: <s5htxbnvbwa.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> 
> Don't include this header here.
> The HD-audio verbs are defined in sound/hda_verbs.h in the usptream tree, so
> include it instead.

I will modify it.
Thanks.

> 
> Takashi
> 
> ------Please consider the environment before printing this e-mail.
