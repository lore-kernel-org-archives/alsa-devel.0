From: Michal Bachraty <michal.bachraty@streamunlimited.com>
Subject: Re: davici-mcasp: "tx-num-evt" confusion with number
	of serializers
Date: Thu, 28 Feb 2013 10:06:58 +0100
Message-ID: <8652573.mejjkM8Cr8@ganymedes>
References: <1631475.f7GPhLiLxV@ganymedes> <4506811.gzuv2dFpKQ@ganymedes>
 <512DF67A.5030906@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.inode.at (mx02.lb01.inode.at [62.99.145.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 3AD52264F23
 for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2013 10:07:01 +0100 (CET)
In-Reply-To: <512DF67A.5030906@topic.nl>
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
Cc: Mike Looijmans <mike.looijmans@topic.nl>
List-Id: alsa-devel@alsa-project.org

Hi Mike,

Many thanks!
Now all about "tx-num-evt" or "rx-num-evt" make sense.  

> Maybe the misleading "rx_num_evt" should be renamed to "use_rx_fifo". I
> understand that not all McASP interfaces have a FIFO

Maybe, "rx_fifo_depth" could be also used.

Best 
Michal
