From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH 3/3] ASoC: cs42l73: Add Device Tree support
	for CS42L73
Date: Thu, 17 Oct 2013 23:51:46 +0000
Message-ID: <CC453167-E102-450F-8813-EEE20B9EFF96@cirrus.com>
References: <1382025815-7912-1-git-send-email-brian.austin@cirrus.com>
 <1382025815-7912-3-git-send-email-brian.austin@cirrus.com>,
 <20131017233953.GY2443@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 11427261622
 for <alsa-devel@alsa-project.org>; Fri, 18 Oct 2013 01:51:54 +0200 (CEST)
In-Reply-To: <20131017233953.GY2443@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org



> On Oct 17, 2013, at 18:40, "Mark Brown" <broonie@kernel.org> wrote:
> 
>> On Thu, Oct 17, 2013 at 11:03:35AM -0500, Brian Austin wrote:
>> This patch adds device tree support for the cs42l73 codec.
>> Reset Gpio and Charge Pump Frequency are available
> 
> Actually this doesn't apply for me, some missing dependency perhaps?  I
> didn't check exactly what's conflicting.

Hmmm.  I'll check when I get in. I'm pretty sure it's off the for-next but I'll check again.
