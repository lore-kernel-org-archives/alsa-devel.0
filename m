From: "mahendra  sp" <mahendra_sp@rediffmail.com>
Subject: Problem  with underrun and overrun
Date: 7 Jul 2003 07:45:41 -0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030707074541.13927.qmail@mailweb34.rediffmail.com>
Reply-To: "mahendra  sp" <mahendra_sp@rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
Cc: James@superbug.demon.co.uk, ilyaphis@mail.ru
List-Id: alsa-devel@alsa-project.org

hi,

   This is regarding UNDERRUN and OVERRUN.
  I want to know how to come out of Underrun and Overrun in case 
of full duplex. In my application, its giving underun (playback)  
ans overrun(capture)  for client and server program.  How to 
overcome them?Is it sufficient to call snd_pcm_prepare(handle)?

   please help.
mahendra

___________________________________________________
Click below to experience Sooraj R Barjatya's latest offering
'Main Prem Ki Diwani Hoon' starring Hrithik, Abhishek
  & Kareena http://www.mpkdh.com



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
