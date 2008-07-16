From: Stewart Adam <maillist@diffingo.com>
Subject: Re: softvol chokes on snd_pcm_rewind
Date: Wed, 16 Jul 2008 11:39:51 -0400
Message-ID: <1216222791.10983.5.camel@Diffingo.localdomain>
Reply-To: s.adam@diffingo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from thelonius.ecohosting.com (thelonius.ecohosting.com [69.90.92.9])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F9EE243AD
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jul 2008 17:39:59 +0200 (CEST)
Received: from modemcable154.214-57-74.mc.videotron.ca ([74.57.214.154]:54929
	helo=[192.168.1.15])
	by thelonius.ecohosting.com with esmtpa (Exim 4.69)
	(envelope-from <maillist@diffingo.com>) id 1KJ96i-0007D2-6p
	for alsa-devel@alsa-project.org; Wed, 16 Jul 2008 11:39:56 -0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm using Fedora 10 development/rawhide and I'm having the same problem
with softvol and alsa-lib-1.0.16 - snd_pcm_rewind() makes the audio
distorted and very high-pitched. Is there a way I could help debug this?

Regards,
Stewart
