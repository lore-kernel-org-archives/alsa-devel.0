From: Richard Liu <richliu@ite.techarea.org>
Subject: [Announce] ITE ac97 codec patch ( IT2226E)
Date: Fri, 09 Aug 2002 15:23:48 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020809151755.C11E.RICHLIU@ite.techarea.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: ALSA-ML <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi. 
  Here have a ITE ac97 codec patch for alsa-driver-0.9.0rc2
ITE is a IC design house which have many IC productions.

ITE develope a AC97 codec for INTEL ICH4, but we found some problem
in probe AC97 codec on ICH4, so I mark the key code,
let snd_intel8x0 can run our chip . 

this code we test in Mandrake 8.2 , I use newest stable release kernel 
2.4.19 and alsa-driver-0.9.0rc2 test it, and ok.

I am sorry I don't know how to avoid intel ICH4's problem for our
production only. 

ITE's homepage : http://www.ite.com.tw

Regards
Richard Liu



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
