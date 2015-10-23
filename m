From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Roland/Edirol M-16DX
Date: Fri, 23 Oct 2015 17:08:46 +0200
Message-ID: <562A4D7E.6040401@ladisch.de>
References: <alpine.DEB.2.02.1510231017080.14239@lnxricardw1.se.axis.com>
 <562A136E.3030108@ladisch.de>
 <alpine.DEB.2.02.1510231640080.14239@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 5D313261A95
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 17:08:50 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1510231640080.14239@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: =?UTF-8?Q?Ricard_Wanderl=c3=b6f?= <ricardw@axis.com>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Ricard Wanderlof wrote:
> On Fri, 23 Oct 2015, Clemens Ladisch wrote:
>> Ricard Wanderlof wrote:
>>> meaning that a device like the M-16DX should function as expected also for
>>> playback?
>>
>> There is some bug in the code that should detect such Roland devices.
>
> I'm not sure what you mean, is there a bug that fails to detect when it is
> necessary to use implcit feedback specifically when using Roland devices?

Yes.


Regards,
Clemens
