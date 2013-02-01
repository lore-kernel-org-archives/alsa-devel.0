From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: PandaBoard ES Audio Problems
Date: Fri, 01 Feb 2013 11:56:18 +0100
Message-ID: <510B9F52.6030503@amarulasolutions.com>
References: <CAAo96ZCNBTGBToLbKnvQ1k_eewJcg94KZBRKt7TKkE3T8xqsQw@mail.gmail.com>
 <510AA9A0.4060009@ladisch.de> <1359656599.10392.13.camel@loki>
 <CAAo96ZDNUY8Sp=kmjGXy5Ro0q7x22XVtO3Uv0VhhJBugUvOfTw@mail.gmail.com>
 <510AC999.2090205@ladisch.de> <1359662400.10392.26.camel@loki>
 <CAAo96ZAZvceSonfd7rzNRCpr0Ey-SQP9vV2rwsy89yT63=Ze5A@mail.gmail.com>
 <1359707373.2432.5.camel@loki> <510B9E49.7000908@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f48.google.com (mail-ee0-f48.google.com [74.125.83.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D571265001
 for <alsa-devel@alsa-project.org>; Fri,  1 Feb 2013 11:56:22 +0100 (CET)
Received: by mail-ee0-f48.google.com with SMTP id t10so2071518eei.21
 for <alsa-devel@alsa-project.org>; Fri, 01 Feb 2013 02:56:21 -0800 (PST)
In-Reply-To: <510B9E49.7000908@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Brent Weatherall <brentweatherall@gmail.com>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, "Guiriec, Sebastien" <s-guiriec@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi

On 02/01/2013 11:51 AM, Peter Ujfalusi wrote:
> On 02/01/2013 09:29 AM, Liam Girdwood wrote:
>> On Thu, 2013-01-31 at 14:13 -0800, Brent Weatherall wrote:
>>> Liam,
>>
>>>      Before I begin to dig around, do you know if there is the
>>> possibility a newer kernel (like 3.7 or something) will have fixed
>>> this issue?
>>>
>> I think Peter will probably have an 3.8rc development branch on
>> gitorious here :-
>>
>> git@gitorious.org:omap-audio/linux-audio.git next/ti-audio-next
> 
> Yes, we have that but it is with dynamic FW which demands different ABE
> firmware...
> I'll go through the thread and try to give some pointers.
> Do we know where to get the sources for the '3.4.0-1487-omap4'?
> 

git://dev.omapzoom.org/pub/scm/integration/kernel-ubuntu.git

Michael
