From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Driver for audio power amplifier ICs?
Date: Thu, 01 Oct 2015 12:20:34 +0200
Message-ID: <560D08F2.1000105@metafoo.de>
References: <999B71E1-5FDB-4EFD-8E69-975C8A09A0C7@latencyzero.com>
 <560CF702.4000106@metafoo.de>
 <62E06779-EF34-4CEE-A415-7777EF888B22@latencyzero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-050.synserver.de (smtp-out-108.synserver.de
 [212.40.185.108])
 by alsa0.perex.cz (Postfix) with ESMTP id 330A926662F
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2015 12:20:36 +0200 (CEST)
In-Reply-To: <62E06779-EF34-4CEE-A415-7777EF888B22@latencyzero.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rick Mann <rmann@latencyzero.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/01/2015 11:08 AM, Rick Mann wrote:
> 
>> The connections between the CODEC and the amplifier need to be specified in
>> the board driver.
> 
> In this case I think that can all be done in the Device Tree, no?

Probably, depends on the exact setup.
