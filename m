From: feng_tian <feng_tian@126.com>
Subject: Can I control volume of each virtual device?
Date: Fri, 7 Dec 2007 10:30:32 +0800 (CST)
Message-ID: <4037871.125781196994632409.JavaMail.coremail@bj126app68.126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m15-68.126.com (m15-68.126.com [220.181.15.68])
	by alsa0.perex.cz (Postfix) with SMTP id 0374424359
	for <alsa-devel@alsa-project.org>; Fri,  7 Dec 2007 03:30:43 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>, alsa-user <alsa-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi, all:
We are on a project using alsa. 
There are three applications will use the sound card, but we only have one physical card.
My plan is to create virtual device for each application. How I'm gonna control the volume of each device, which interface to use?
I want this feature because when one application need to be exclusive, it can mute the other virtual devices.
Any comments or advices is welcome.  Thanks

BR
Feng
