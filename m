From: Peter Heatwole <peter599@gotnet.net>
Subject: cs46xx: defaults to revision 1.03 AC97 codec
Date: Thu, 25 Jul 2002 15:33:11 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020725223311.GC2919@porky>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

    I noticed in cs46xx_lib.c that the cs46xx driver defaults to 
instructing
the chip that it will be using a 1.03 revision AC97 codec versus a 2.0
revision codec. What are the advantages and disadvantages of this?


-- Peter Heatwole
"Murphy was just a well known pessimist."


-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
