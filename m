From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: The state of Linux audio
Date: Mon, 25 Aug 2008 09:07:54 +0100
Message-ID: <g8tp8q$c4b$1@ger.gmane.org>
References: <f188924b0808240837nfb54b9aq6330d9994df291ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 43235245B6
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Aug 2008 10:08:08 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KXX7M-0000UI-41
	for alsa-devel@alsa-project.org; Mon, 25 Aug 2008 08:08:04 +0000
Received: from 80-192-67-147.cable.ubr10.edin.blueyonder.co.uk
	([80.192.67.147]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 25 Aug 2008 08:08:04 +0000
Received: from gmane by 80-192-67-147.cable.ubr10.edin.blueyonder.co.uk with
	local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 25 Aug 2008 08:08:04 +0000
In-Reply-To: <f188924b0808240837nfb54b9aq6330d9994df291ba@mail.gmail.com>
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

Fred . wrote:
> What is the state of audio in Linux?
> How does it compare against other operating systems?
> 
> Is the Linux audio functionality good or bad?
> What could be better?
> What is planned for the future?

Rather open ended questions! Is there a reason why you are asking or 
just curious?

It depends what you are looking for really (desktop, pro etc.) but Linux 
audio is arguably a bit of a mess with lots of APIs and abstractions 
layers/libraries and a lack of a single common, agreed structure.

On the desktop, most distributions and people are pinning their hopes on 
PulseAudio.

I'd advise you look at the following presentation:
http://foss.in/2007/register/speakers/talkdetailspub.php?talkid=353

This is by the PulseAudio author Lennart Pottering and has a small 
section on the state of linux audio and what PulseAudio is trying to do 
to consolidate this work and provide a common platform to move forward 
in the desktop space.

HTHs

Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
   Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
   Mandriva Linux Contributor [http://www.mandriva.com/]
   PulseAudio Hacker [http://www.pulseaudio.org/]
   Trac Hacker [http://trac.edgewall.org/]
