From: Dave Andruczyk <djandruczyk@yahoo.com>
Subject: Monitoring output in realtime, is it possible?
Date: Wed, 20 Mar 2002 18:58:26 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020321025826.32954.qmail@web14107.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



Is there any way to monitor the audio output, of ANY channels via some setup in
.asoundrc??  I'm looking to do what the older ALSA 0.5.x loopback did.  My app
did have ALSA support until that portion was dropped with the 0.9.x series.  

Has anyone been able to get a loopback copy of audio being output? (both native
and OSS emulation loopback would be ideal. 0.5.x had both OSS emul and native
ALSA loopback ability (albeit a bit limited, but worked well for the most
part))

The more generic it is the better.  I know there are other apps that would
benefit from this functionality. (being able to record the output of one app,
in realtime, for example or App independant Vu meters/Anaylyzers among other
things)





=====
Dave J. Andruczyk
Enterprise Resource Providers

__________________________________________________
Do You Yahoo!?
Yahoo! Movies - coverage of the 74th Academy Awards®
http://movies.yahoo.com/

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
