From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH resend] ASoC: adau1701: add regulator
	consumer support
Date: Mon, 20 Apr 2015 12:26:03 +0200
Message-ID: <5534D43B.7060809@metafoo.de>
References: <1429521123-12764-1-git-send-email-pascal.huerst@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-068.synserver.de (smtp-out-068.synserver.de
 [212.40.185.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 62A372654C9
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2015 12:26:02 +0200 (CEST)
In-Reply-To: <1429521123-12764-1-git-send-email-pascal.huerst@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: pascal.huerst@gmail.com
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, patch@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 04/20/2015 11:12 AM, pascal.huerst@gmail.com wrote:
> From: Pascal Huerst <pascal.huerst@gmail.com>
>
> The adau1701 has two power domains, DVDD and AVDD.
> Enable them both as long as the codec is in use.
>
> Signed-off-by: Pascal Huerst <pascal.huerst@gmail.com>


Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.
