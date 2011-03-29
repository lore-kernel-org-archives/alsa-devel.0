From: Goncalo Pinheira <goncalopp@gmail.com>
Subject: emu10k1, midi on audigy platinum ex
Date: Tue, 29 Mar 2011 11:47:51 +0100
Message-ID: <4D91B8D7.2000504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sapo.pt (relay1.ptmail.sapo.pt [212.55.154.21])
	by alsa0.perex.cz (Postfix) with SMTP id 15327243AF
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Mar 2011 12:47:58 +0200 (CEST)
Received: from unknown (HELO cp.goncalopp.com)
	(as11656677@sapo.pt@[85.240.138.230])
	(envelope-sender <goncalopp@gmail.com>)
	by mta14 (qmail-ptmail-1.0.0) with AES256-SHA encrypted SMTP
	for <alsa-devel@alsa-project.org>; 29 Mar 2011 10:47:53 -0000
Received: from [192.168.0.5] (pekkala [192.168.0.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by cp.goncalopp.com (Postfix) with ESMTPSA id 51094A0E9
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Mar 2011 11:47:45 +0100 (WEST)
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

Hello,
I've noticed midi in (DIN connector) on an audigy platinum ex doesn't work.
There's a patch in a 2009 forum thread
http://ubuntuforums.org/showthread.php?t=1354637&page=3
The author seems to have contacted with the alsa project, but the latest 
kernel shows no sign of the code. Shouldn't this be commited?
