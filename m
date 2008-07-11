From: "D. Sen" <dsen@homemail.com>
Subject: Re: RME madiface
Date: Fri, 11 Jul 2008 17:58:32 +1000
Message-ID: <487712A8.6020403@homemail.com>
References: <48769BDC.80007@homemail.com>	<200807110626.52197.faber@faberman.de>	<4877029F.6080006@homemail.com>
	<200807110954.31479.faber@faberman.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth14.prod.mesa1.secureserver.net
	(smtpauth14.prod.mesa1.secureserver.net [64.202.165.39])
	by alsa0.perex.cz (Postfix) with SMTP id 7EAC024873
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Jul 2008 09:58:46 +0200 (CEST)
In-Reply-To: <200807110954.31479.faber@faberman.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Florian Faber <faber@faberman.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sure ...going over to private email.

Florian Faber wrote:
> Dee,
> 
>>>> Any ideas?
>>> There is no difference on the MADI bus wether you use Windows, OS X
>>> or Linux. This seems to be a specific problem with the Euphonix.
>> I have no reason to believe the MADI bus is different. However, I
>> suspect the stream are different.
> 
> The MADI cards work autonomous, they are only controlled by a few 
> parameters. If the parameters are the same, the behaviour is the same. 
> Thus the settings must differ, and we have to find out where.
> 
>> I have two Euphonix boxes and they both behave perfectly under
>> windows - but not under linux. The main problem under linux is that
>> they lose sync - at the slightest electromagnetic interference (such
>> as turning off/on the speakers - on the analogue side - even from a
>> distance of 3 metres). 
> 
> I don't believe electromagnetic interference to be a reasonable cause 
> for this. What exactly is your setup - 1x 703 and 1x 713? And both lose 
> sync?
> 
> I just had a glance over the Euphonix' user manual and had to learn that 
> they cannot loop through MADI and you have to use the wordclock. So, 
> please, be a bit more specific about the setup - and maybe via private 
> mail, because that's of no relevance to alsa development..
> 
> 
> Flo
