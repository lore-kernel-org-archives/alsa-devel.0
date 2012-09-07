From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: ALSA release cycle
Date: Fri, 07 Sep 2012 14:51:10 +0200
Message-ID: <5049EDBE.2090005@canonical.com>
References: <5049DCA4.6000607@canonical.com> <5049E164.3000405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id C06CE2616B5
 for <alsa-devel@alsa-project.org>; Fri,  7 Sep 2012 14:51:10 +0200 (CEST)
In-Reply-To: <5049E164.3000405@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 09/07/2012 01:58 PM, Daniel Mack wrote:
> On 07.09.2012 13:38, David Henningsson wrote:
>> Hi,
>>
>> At Plumber's we discussed the ALSA release cycle. Our releases recently
>> have been irregular, and the reasoning behind why a release was done at
>> that time, has not been very obvious.
>>
>> IIRC, we kind of leaned towards releasing every six months. I don't
>> remember if there was any consensus about whether to try to align this
>> cycle to something else (e g Gnome, KDE, Fedora, Ubuntu, etc), or not.
>
> ... or the kernel? At least for the kernel parts of ALSA, syncing an
> ALSA version to kernel version would automatically tell us which patches
> will make it into a new release. Plus, it would also be easier to
> compare feature sets (something like "ALSA 1.0.26 gives us what we have
> in kernel 3.6").
>
> Would that be feasible or am I missing something?

I took that up as an alternative. I think more people leaned towards six 
month cycles, but it's still an open question.

To me, I also think aligning releases to the kernel makes sense, but 
it'll also mean a lot of releases with little change in, so maybe six 
month cycles are better for that reason.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
