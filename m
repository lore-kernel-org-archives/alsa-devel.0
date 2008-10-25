From: Jelle de Jong <jelledejong@powercraft.nl>
Subject: Re: volume scaling of usb audio class headset
Date: Sat, 25 Oct 2008 11:16:13 +0200
Message-ID: <4902E3DD.3020304@powercraft.nl>
References: <49020760.9080900@powercraft.nl>
	<74eb1fe20810241113q7ee8aa9ah63cf5346c6b940c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from node04.cambriumhosting.nl (node04.cambriumhosting.nl
	[217.19.16.165]) by alsa0.perex.cz (Postfix) with ESMTP id 2FB8B244AA
	for <alsa-devel@alsa-project.org>;
	Sat, 25 Oct 2008 11:16:34 +0200 (CEST)
In-Reply-To: <74eb1fe20810241113q7ee8aa9ah63cf5346c6b940c1@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sean McNamara <smcnam@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sean McNamara wrote:
> There is a *huge* (83 replies) thread in the alsa-devel ML archives
> about this problem. Lennart Poettering raised the issue regarding his
> Logitech external USB speakers.
> 
> http://article.gmane.org/gmane.linux.alsa.devel/52524
> 
> Sort through the replies to see if you can make any sense out of the
> workarounds, patches, and so on that resulted from this discussion. If
> possible, try the latest GIT alsa-driver and alsa-lib.
> 
> Sean
> 
> On Fri, Oct 24, 2008 at 1:35 PM, Jelle de Jong
> <jelledejong@powercraft.nl> wrote:
>> Hello everybody,
>>
>> I got a question, I got a few usb headsets that seem to apply to the usb
>> audio class and the volume scale is way to big with alsa. with the
>> control on 10 of the 100 you are almost getting deaf. So my question is
>> how does alsa make an scaling for such devices and how to fix it so that
>> the full range can be used in a normal volume spectrum.
>>
>> Thank in advance,
>>
>> Jelle

Thank you Sean for responding to the question, it seems I was not the
only one with this issue. I got one more following question, which usb
headset and usb audio adapters can I buy right now that are not effected
by this issue? Or should I just wait until the upcoming releases that
will hopefully fix the problem for all usb audio devices, or is this
false hope?

Best regards,

Jelle
