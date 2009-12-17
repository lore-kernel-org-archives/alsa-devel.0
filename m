From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Subject: alsa device drain power
Date: Thu, 17 Dec 2009 09:47:59 +0100
Message-ID: <4B29F03F.4020100@gandalf.sssup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sssup.it (ms01.sssup.it [193.205.80.99])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E77410382D
	for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2009 09:48:04 +0100 (CET)
Received: from [193.205.82.7] (HELO gandalf.sssup.it)
	by sssup.it (CommuniGate Pro SMTP 4.1.8)
	with ESMTP-TLS id 56347590 for alsa-devel@alsa-project.org;
	Thu, 17 Dec 2009 09:46:49 +0100
Received: from [10.30.3.179] (vpn179.retis [10.30.3.179])
	by gandalf.sssup.it (8.12.10/8.12.10) with ESMTP id nBH8lxeI014664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2009 09:48:03 +0100
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

Hi all,

I have a simple question is the general behavior that an alsa device 
start to drain power
when it starts to play sound or start to recording. What happen if there 
is an external amplifier
connect to sound device?

Michael
