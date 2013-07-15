From: Nicolin Chen <b42378@freescale.com>
Subject: Re: ASoC: codec: SPDIF only works with Tx/Rx seperate
 codec drivers?
Date: Mon, 15 Jul 2013 10:11:49 +0800
Message-ID: <20130715021148.GA2257@MrMyself>
References: <20130712083030.GA28555@MrMyself>
 <51E01209.9020904@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 410A426031E
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2013 04:30:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <51E01209.9020904@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Fri, Jul 12, 2013 at 04:26:17PM +0200, Lars-Peter Clausen wrote:
> The current drivers should work fine with this. You can create a card with
> two DAI links

I'll try it. Thank you so much!
