From: Dolevo Jay <cmst@live.com>
Subject: How to properly restart after config change
Date: Fri, 29 Nov 2013 12:22:53 +0000
Message-ID: <DUB122-W2DB54619B660931AC34D8AAE90@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dub0-omc3-s21.dub0.hotmail.com (dub0-omc3-s21.dub0.hotmail.com
 [157.55.2.30]) by alsa0.perex.cz (Postfix) with ESMTP id 6632226556D
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 13:22:54 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi experts,

In my application, I some parameters in the asound.conf at runtime. However, after my software edits and changes the necessary parameters, the application still runs with the old configuration. If I run aplay, it works fine and runs with the new config but not my application. So, could anyone tell me what I should do extra after changing the parameters? Perhaps a small restart of something? 

thanks.
 		 	   		  
