From: Sergej Sawazki <sergej@taudac.com>
Subject: Re: [PATCH] ASoC: wm8741: Use snd_soc_update_bits
 rather than hard coding
Date: Thu, 2 Nov 2017 13:17:07 +0100
Message-ID: <567cc1de-d107-64d3-fa64-ebe9353759f6@taudac.com>
References: <20171101110325.2433-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from s62.goserver.host (s62.goserver.host [37.17.224.62])
 by alsa0.perex.cz (Postfix) with ESMTP id E5A4C266DEA
 for <alsa-devel@alsa-project.org>; Thu,  2 Nov 2017 13:17:29 +0100 (CET)
In-Reply-To: <20171101110325.2433-1-ckeepax@opensource.cirrus.com>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org
Cc: ce3a@gmx.de, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Am 01.11.2017 um 12:03 schrieb Charles Keepax:
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> Only build tested but Sergej should be able to test on actually hardware for us.

> 
> 

Thanks Charles,

works on my setup.

Tested-by: Sergej Sawazki <sergej@taudac.de>

Sergej
