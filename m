From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 1/5] ASoC: Correct typo in
	SOC_VALUE_ENUM_SINGLE macro
Date: Fri, 01 May 2015 16:31:02 +0200
Message-ID: <55438E26.9000908@metafoo.de>
References: <1430480247-28753-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-190.synserver.de (smtp-out-205.synserver.de
 [212.40.185.205])
 by alsa0.perex.cz (Postfix) with ESMTP id 30E3E26061A
 for <alsa-devel@alsa-project.org>; Fri,  1 May 2015 16:31:59 +0200 (CEST)
In-Reply-To: <1430480247-28753-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 05/01/2015 01:37 PM, Charles Keepax wrote:
> xnitmes is clearly intended to be xnitems, but all other macros just
> refer to this as xitems, so change it to that.
>
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Looks good, works fine, thanks. Patch 1-4:

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
Tested-by: Lars-Peter Clausen <lars@metafoo.de>
