From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l56: Fix stereo channel register
 assignment for Headphone and LineOut volume mixers
Date: Mon, 23 Jun 2014 11:37:06 -0500
Message-ID: <alpine.DEB.2.02.1406231136430.25941@heelrod>
References: <1403540273-15231-1-git-send-email-ryan.harvey@cirrus.com>
 <alpine.DEB.2.02.1406231124500.25941@heelrod>
 <20140623162642.GB23300@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (dns-bn1lp0143.outbound.protection.outlook.com [207.46.163.143])
 by alsa0.perex.cz (Postfix) with ESMTP id E1E3F2655CE
 for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2014 18:34:36 +0200 (CEST)
In-Reply-To: <20140623162642.GB23300@sirena.org.uk>
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
Cc: Brian Austin <brian.austin@cirrus.com>, paul.handrigan@cirrus.com, alsa-devel@alsa-project.org, Ryan Harvey <ryan.harvey@cirrus.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, 23 Jun 2014, Mark Brown wrote:

> On Mon, Jun 23, 2014 at 11:25:18AM -0500, Brian Austin wrote:
>> On Mon, 23 Jun 2014, Ryan Harvey wrote:
>>
>>> Stereo Headphone and LineOut volume mixers are now attached to HPA+HPB, LOA+LOB.
>
> I don't seem to have been copied on the original patches here, or
> they're snarled up somewhere in transmission anyway.
>
You're there. Maybe stuck in Moderator with first post to mailing list?
