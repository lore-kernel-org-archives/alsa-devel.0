From: Julian Scheel <julian@jusst.de>
Subject: Re: [PATCH] speaker-test: Add option to specify signal
 scale
Date: Fri, 17 Jul 2015 18:02:23 +0200
Message-ID: <55A9270F.10307@jusst.de>
References: <1435647469-30754-1-git-send-email-julian@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender163-mail.zoho.com (sender163-mail.zoho.com
 [74.201.84.163])
 by alsa0.perex.cz (Postfix) with ESMTP id E5ACF260574
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2015 18:02:29 +0200 (CEST)
In-Reply-To: <1435647469-30754-1-git-send-email-julian@jusst.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

Am 30.06.2015 um 08:57 schrieb Julian Scheel:
> Allow generated signals (sine and noise) to have a specified signal scale
> instead of using hardcoded limits of 80%. This can be handy for debugging, ie
> when analysing clipping issues with audio drivers.
>
> Signed-off-by: Julian Scheel <julian@jusst.de>
> ---

any objections on this patch?

-Julian
