From: cee1 <fykcee1@gmail.com>
Subject: Question about dmix?
Date: Sat, 20 Mar 2010 22:05:52 +0800
Message-ID: <4df68b71003200705j36e71a8aicf9c44fb7f104c27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f191.google.com (mail-qy0-f191.google.com
	[209.85.221.191])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F38524390
	for <alsa-devel@alsa-project.org>; Sat, 20 Mar 2010 15:05:55 +0100 (CET)
Received: by qyk29 with SMTP id 29so1647142qyk.2
	for <alsa-devel@alsa-project.org>; Sat, 20 Mar 2010 07:05:52 -0700 (PDT)
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
I know alsa support userspace software multi-playback by dmix plugin.
How does it realize? I expected a daemon accepting multi-streams which
then mixes these streams to a single one -- it seems not the case.


Regards,
