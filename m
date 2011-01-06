From: Florian Faber <faber@faberman.de>
Subject: Re: [PATCH] ASoC: SAMSUNG: Remove NEO1973(GTA01) audio
 driver
Date: Thu, 06 Jan 2011 12:27:35 +0100
Message-ID: <4D25A727.3080701@faberman.de>
References: <1294273308-25124-1-git-send-email-sw.youn@samsung.com>	<AANLkTik9u5ETmdbd3MrbJfdqEYguCdVvhA2225Uks2_4@mail.gmail.com>
	<20110106112055.GF746@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from india820.server4you.de (india820.server4you.de [85.25.152.101])
	by alsa0.perex.cz (Postfix) with ESMTP id A361D2440A
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 12:27:53 +0100 (CET)
In-Reply-To: <20110106112055.GF746@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 01/06/11 12:20, Mark Brown wrote:
> On Thu, Jan 06, 2011 at 10:23:20AM +0900, Jassi Brar wrote:
>> 'If anybody has any objections speak now or forever hold your peace' :)
> I'd rather hold off on this - the OpenMoko guys are actively working on
> this (there's just a couple of people doing it as a hobby project) and
> I'd rather not make their lives any harder.  The last time I checked
> they had reorganised things to merge the GTA01 and GTA02 into a single
> machine driver.  Plus I have a GTA01 (not that I've actually used it for
> years).

The OpenMoko became more interesting again with the new open source
baseband stack Harald Welte et al have presented at the 27C3. So it
would be really bad timing to remove the drivers right now.


Flo
-- 
Machines can do the work, so people have time to think.
public key B3B9226C          x-hkp://wwwkeys.eu.pgp.net
