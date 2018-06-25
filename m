From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH 3/3] ASoC: simple-card: add support for
 clock divider setup
Date: Mon, 25 Jun 2018 14:55:12 +0200
Message-ID: <f7e05fe9-c177-9a78-e09d-0f74c2427b63@zonque.org>
References: <20180528193503.18905-1-daniel@zonque.org>
 <20180528193503.18905-4-daniel@zonque.org>
 <20180529113509.GE23509@sirena.org.uk>
 <d6b9da97-8c71-ccfb-07e4-353620396a31@zonque.org>
 <20180530091011.GA6920@sirena.org.uk>
 <ace99dbd-3480-9ac3-e5b8-4ddae73bba10@zonque.org>
 <b006a926-09ff-59e0-2b88-6f15e3e714e9@zonque.org>
 <20180625112440.GE9413@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EF7C26720C
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 14:55:14 +0200 (CEST)
In-Reply-To: <20180625112440.GE9413@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

On Monday, June 25, 2018 01:24 PM, Mark Brown wrote:
> On Sat, Jun 23, 2018 at 08:41:27PM +0200, Daniel Mack wrote:
> 
>> I'd like to get some of this done for 4.19, but for that, I'd need Robert's
>> patch that addresses DMA compat issues in your tree.
> 
>> Not sure if you've followed the thread titled '[PATCH v3 09/14] ASoC: pxa:
>> remove the dmaengine compat need' - could you chime in there?
> 
> No, I reviewed my patch in there.  What's going on?
> 

I'd like this patch to go through your tree, if that's okay. Then I can 
post some more patches on top without causing a conflict in the merge 
window.

Robert is fine with that.


Thanks,
Daniel
